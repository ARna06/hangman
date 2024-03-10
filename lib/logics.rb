require 'yaml'

class Hangman

  def initialize(key)
    @@word_hash = Hash.new(0)
    @@refractor = ['_'] * (key.length-1)
    @@garbage = Array.new(0)
    key.chars.each_with_index do |item, index|
      @@word_hash[index.to_s] = item
    end
  end

  def self.play(guess)
    if @@word_hash.has_value?(guess)
      req_index = @@word_hash.key(guess).to_i
      @@refractor[req_index] = guess
      @@word_hash[req_index.to_s] = ''
    else
      @@garbage.append(guess)
    end
    return @@refractor
  end

  def self.refractor
    return @@refractor
  end

  def self.not_in_word
    return @@garbage
  end

  def self.lives
    return (8 - @@garbage.length)
  end

  def self.secret_word
    arr = []
    @@refractor.each_with_index do |item, idx|
      if item != '_'
        arr.append(item)
      else
        arr.append(@@word_hash[idx.to_s])
      end
    end
    return arr.join('')
  end

  def self.save
    Dir.mkdir('saves') unless Dir.exist?('saves')

    req = {
      :refractor => @@refractor,
      :word_hash => @@word_hash,
      :garbage => @@garbage,
    }

    File.open('saves/save.yaml', 'w') do |file|
      file.puts YAML.dump(req)
    end
  end

  def self.reload(yaml)
    begin
      dats = YAML.load(yaml)
      @@refractor = dats[:refractor]
      @@word_hash = dats[:word_hash]
      @@garbage = dats[:garbage]
    rescue
      puts "The save file may not exist or got corrupted, please start a new game!"
    end
  end

end
