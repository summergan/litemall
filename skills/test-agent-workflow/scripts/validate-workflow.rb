#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

workflow = File.expand_path("..", __dir__)
repo = File.expand_path("../../..", workflow)
index_path = File.join(workflow, "skill-index.yml")
index = YAML.load_file(index_path)
errors = []

paths = []
index.fetch("top_level_entrypoints").each_value { |entry| paths << entry["path"] }
index.fetch("skills").each_value do |entry|
  paths << entry["path"]
  paths.concat(entry.fetch("references", []))
end

paths.compact.uniq.each do |relative|
  errors << "indexed path does not exist: #{relative}" unless File.exist?(File.join(repo, relative))
end

legacy_paths = [
  "test-case-design/existing-case-discovery/SKILL.md",
  "06-test-execution/test-implementation/SKILL.md",
  "06-test-execution/references/testing-patterns.md"
]
legacy_paths.each do |relative|
  errors << "legacy node still exists: #{relative}" if File.exist?(File.join(workflow, relative))
end

design = File.read(File.join(workflow, "test-case-design/SKILL.md"))
review = File.read(File.join(workflow, "04-test-case-quality-review/SKILL.md"))
strategy = File.read(File.join(workflow, "05-test-strategy/SKILL.md"))
execution = File.read(File.join(workflow, "06-test-execution/SKILL.md"))

%w[evidence_layer layer_skill command_source execution_profile].each do |term|
  errors << "Case Design owns strategy field: #{term}" if design.include?(term)
end

%w[selected_evidence_layers execution_size command_source].each do |term|
  errors << "Case Review owns strategy field: #{term}" if review.include?(term)
end

%w[test_case_id execution_id layer_skill command_source runtime expected_evidence].each do |term|
  errors << "Test Strategy misses execution field: #{term}" unless strategy.include?(term)
end

%w[test_case_id execution_id PASSED FAILED BLOCKED NOT_PROVEN INCOMPLETE].each do |status|
  errors << "Test Execution misses result status: #{status}" unless execution.include?(status)
end

test_index_path = File.join(repo, "litemall/Tests/test-index.yml")
if File.exist?(test_index_path)
  test_index = YAML.load_file(test_index_path)
  %w[functional_layers quality_gates runner_checks optional_tools].each do |section|
    errors << "test-index misses section: #{section}" unless test_index[section].is_a?(Hash)
  end
  errors << "test-index still mixes gates and layers" if test_index.key?("layers")
end

builder_path = File.join(repo, "AI Native/scripts/build-litemall-quality-kb.py")
benchmark_path = File.join(repo, "AI Native/scripts/run-litemall-skill-benchmark.py")
pack_path = File.join(repo, "AI Native/workflows/litemall-payment/workflow-pack.json")
quality_kb_path = File.join(repo, "AI Native/quality-kb/litemall-quality-kb.json")

if File.exist?(builder_path)
  builder = File.read(builder_path)
  errors << "KB builder does not fingerprint test-agent-workflow" unless builder.include?("test-agent-workflow")
  errors << "KB builder still fingerprints removed workflow" if builder.include?("litemall-testing-workflow")
end

if File.exist?(benchmark_path)
  benchmark = File.read(benchmark_path)
  errors << "benchmark does not inspect test-agent-workflow" unless benchmark.include?("test-agent-workflow")
  errors << "benchmark still inspects removed workflow" if benchmark.include?("litemall-testing-workflow")
  errors << "benchmark still requires review score" if benchmark.include?('quality.get("overall_score"')
end

if File.exist?(pack_path)
  pack = File.read(pack_path)
  errors << "workflow pack is not schema version 2" unless pack.include?('"schema_version": 2')
  errors << "workflow pack misses layer-neutral case design" unless pack.include?('"case_design"')
  errors << "workflow pack misses test strategy" unless pack.include?('"test_strategy"')
  errors << "workflow pack still stores review score" if pack.include?('"overall_score"')
end

if File.exist?(quality_kb_path)
  quality_kb = File.read(quality_kb_path)
  errors << "quality KB still contains removed workflow path" if quality_kb.include?("litemall-testing-workflow")
  errors << "quality KB still contains Planner Handoff evidence" if quality_kb.include?("Planner Handoff")
  errors << "quality KB misses current review Skill" unless quality_kb.include?("test-agent-workflow/04-test-case-quality-review/SKILL.md")
end

scanned = Dir[File.join(workflow, "**", "*.{md,yml,yaml}")]
forbidden = ["project/", "test-implementation", "testing-patterns.md", "lite" + "mall"]
scanned.each do |file|
  text = File.read(file)
  forbidden.each do |term|
    errors << "forbidden stale term #{term.inspect} in #{file.delete_prefix(repo + "/")}" if text.include?(term)
  end
end

if errors.empty?
  puts "workflow validation passed"
  puts "indexed_paths=#{paths.compact.uniq.size}"
  puts "skills=#{Dir[File.join(workflow, '**', 'SKILL.md')].size}"
  exit 0
end

warn errors.uniq.join("\n")
exit 1
