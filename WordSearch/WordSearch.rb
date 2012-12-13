# -*- coding: utf-8 -*-
#
# WordSearch.rb
# Gyaim
#
# Created by Toshiyuki Masui on 2011/3/15.
# Copyright 2011 Pitecan Systems. All rights reserved.

require 'Crypt'
require 'Dictionary'

class WordSearch
  attr_accessor :searchmode

  def initialize(dictfile, localDictFile="#{WordSearch.dictDir}/localdict.txt", studyDictFile="#{WordSearch.dictDir}/studydict.txt")
    @searchmode = 0
    @dictionary = Dictionary.new(dictfile)
    @localdict  = Dictionary.new(localDictFile) 
    @studydict  = Dictionary.new(studyDictFile)
    @dictionaries = [@studydict, @localdict, @dictionary]
  end

  def self.dictDir
    File.expand_path("~/.gyaimdict")
  end

  def self.setup
    Dir.mkdir(dictDir) unless File.exist?(dictDir)    
  end

  def search(q, limit=10)
    return [] if q.nil? || q == ''

    @candidates = @dictionaries.collect { |dict| dict[q] }
      .flatten
      .compact
  end

  def candidates
    @candidates
  end

  #
  # ユーザ辞書登録
  #
  def register(word, pattern)
    # puts "register(#{word},#{pattern})"
    # if !@localdict.index([pattern,word]) then
    #   @localdict.unshift([pattern,word])
    #   saveDict(localDictFile,@localdict)
    # end
  end

  #
  # 学習辞書の扱い
  #
  def study(word, pattern)
    # puts "study(#{word},#{pattern})"
    # if pattern.length > 1 then                    # (間違って変な単語を登録しないように)
    #   registered = false
    #   @cd.search(pattern, @searchmode){ |w,p,outc|
    #     next if w =~ /\*$/
    #     w.gsub!(/\*/,'')
    #     if w == word
    #       registered = true
    #       break
    #     end
    #   }

    #   if !registered then
    #     if @studydict.index([yomi,word]) then  # しかし学習辞書に入っている
    #       register(word,yomi)                  # ならば登録してしまう
    #     end
    #   end
    # end

    # @studydict.unshift([yomi,word])
    # @studydict = @studydict[0..1000] # 1000行に制限
  end

  def start
    # 変換ウィンドウが出るときにこれを読んでいるのだが、これを
    # 実行すると変換が遅れて文字をとりこぼしてしまう。
    # たいした処理をしてないのに何故だろうか?
    # Thread.new do
    #  @studydict = loadDict(studyDictFile)
    # end
    # どうしても駄目なのでロードするのをやめる。再ロードしたいときはKillすることに...
  end

  def finish
    @studydict.save(studyDictFile)
  end

end