require 'json'
require_relative '../classes/source'

class PreserveSources
  def gets_sources
    return [] unless File.exist?('./data/sources.json')

    sources = []
    file = File.read('./data/sources.json')
    return [] if file.empty?

    sources_data = JSON.parse(file)
    sources_data['sources'].each do |source_name|
      sources << Source.new(source_name)
    end
    sources
  end

  def save_sources(sources)
    return if sources.empty?

    valid_sources = sources.select { |source| source.is_a?(Source) }

  sources_data = { sources: valid_sources.map(&:source_name) }
  File.open('./data/sources.json', 'w') do |file|
    file.puts(JSON.generate(sources_data))
  end
  end
end
