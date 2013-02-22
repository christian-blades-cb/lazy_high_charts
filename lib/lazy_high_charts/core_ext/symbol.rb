class Symbol
  def camelize
    to_s.camelize(false).to_sym
  end
end
