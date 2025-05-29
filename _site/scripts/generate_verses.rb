require 'json'
require 'fileutils'

# Load data
translations = JSON.parse(File.read('_data/translations.json'))
verses_data = JSON.parse(File.read('_data/verses.json'))

# Build verse_id → chapter_number and verse_number map
verse_lookup = {}
verses_data.each do |v|
  verse_lookup[v["id"]] = {
    chapter: v["chapter_number"],
    verse: v["verse_number"]
  }
end

# Language suffix mapping
lang_suffix = {
  "english" => "en",
  "hindi" => "hi"
}

# Output folder
FileUtils.mkdir_p('_verses')

translations.each do |t|
  lang = t["lang"]&.downcase
  suffix = lang_suffix[lang]
  next unless suffix  # Skip other languages

  verse_id = t["verse_id"]
  text = t["description"] || "No translation"
  author = t["authorName"]

  # Get chapter and verse number from lookup table
  if verse_lookup[verse_id]
    chapter_number = verse_lookup[verse_id][:chapter]
    verse_number = verse_lookup[verse_id][:verse]
  else
    puts "❌ Missing verse_id #{verse_id} in verses.json"
    next
  end

  filename = "_verses/chapter-#{chapter_number}-verse-#{verse_number}.#{suffix}.md"

  File.open(filename, 'w') do |file|
    file.puts("---")
    file.puts("layout: verse")
    file.puts("title: Chapter #{chapter_number} Verse #{verse_number} (#{lang.capitalize})")
    file.puts("chapter: #{chapter_number}")
    file.puts("verse: #{verse_number}")
    file.puts("lang: #{suffix}")
    file.puts("author: #{author}")
    file.puts("---")
    file.puts("")
    file.puts(text.strip)
  end
end

puts "✅ Verse files generated with proper names and fallback mapping!"
