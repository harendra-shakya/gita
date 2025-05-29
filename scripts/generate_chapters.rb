require 'json'
require 'fileutils'

# Load chapter data
chapters = JSON.parse(File.read('_data/chapters.json'))

# Create the _chapters directory
FileUtils.mkdir_p('_chapters')

chapters.each do |chapter|
  num = chapter["chapter_number"]
  name = chapter["name"]
  meaning = chapter["name_meaning"]
  summary_en = chapter["chapter_summary"]
  summary_hi = chapter["chapter_summary_hindi"]

  # English file
  filename_en = "_chapters/chapter-#{num}.en.md"
  File.open(filename_en, 'w') do |f|
    f.puts("---")
    f.puts("layout: chapter")
    f.puts("title: Chapter #{num}: #{name} (#{meaning})")
    f.puts("chapter: #{num}")
    f.puts("lang: en")
    f.puts("permalink: en/chapter/#{num}")
    f.puts("---")
    f.puts("")
    # f.puts("## 📘 English Summary")
    f.puts(summary_en.strip)
  end

  # Hindi file
  filename_hi = "_chapters/chapter-#{num}.hi.md"
  File.open(filename_hi, 'w') do |f|
    f.puts("---")
    f.puts("layout: chapter")
    f.puts("title: Chapter #{num}: #{name} (#{meaning})")
    f.puts("chapter: #{num}")
    f.puts("lang: hi")
    f.puts("permalink: hi/chapter/#{num}")
    f.puts("---")
    f.puts("")
    # f.puts("## 📗 हिंदी सारांश")
    f.puts(summary_hi.strip)
  end
end

puts "✅ Chapter files generated: English and Hindi versions!"
