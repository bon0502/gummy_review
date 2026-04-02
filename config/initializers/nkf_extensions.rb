require 'nkf'

class String
  def hiragana_to_katakana
    NKF.nkf('-W -w --katakana', self)
  end

  def katakana_to_hiragana
    NKF.nkf('-W -w --hiragana', self)
  end
end
