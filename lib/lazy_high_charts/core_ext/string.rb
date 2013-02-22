class JsMonster < String
  def js_code
    self
  end

  def to_s
    self
  end

  def to_json(*a)
    self
  end

  def js_code?
    true
  end
end

String.class_eval do
  def camelize(uppercase_first_letter = true)
    if uppercase_first_letter then
      sub!(%r{^[a-z\d]*}) { $&.capitalize }
    else
      sub!(%r{^(?:/(?=a)b/(?=\b|[A-Z_])|\w)}) { $&.downcase }
    end
    replace gsub(%r{(?:_|(\/))([a-z\d]*)}) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
  end

  def js_code
    JsMonster.new(self)
  end

  def js_code?
    false
  end  
end


