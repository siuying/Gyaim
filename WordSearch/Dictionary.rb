# A simple IME table backed by memory
class Dictionary
  def initialize(dictfile)
    @dict = {}

    File.open(dictfile) do |file|
      file.each do |line|
        line.strip!
        next if line =~ /^#/
        next if line.empty?

        (pattern, word) = line.split(/\s+/)
        if pattern && word
          @dict[pattern] ||= []
          @dict[pattern] << word
        end
      end
    end
  end

  def [](pattern)
    if pattern.match("\\*")
      head          = pattern.split("*").first
      match_pattern = Regexp.new(pattern.gsub(/\*/, ".+"))
      @dict.select { |pattern| pattern.match(match_pattern) }.values.flatten

    else
      @dict[pattern]

    end
  end

  def save(dictfile)
    saved = {}

    File.open(dictfile,"w") do |f|
      dict.each do |entry|
        pattern = entry[0]
        word    = entry[1]
        f.puts "#{pattern}\t#{word}"
      end
    end
  end
end