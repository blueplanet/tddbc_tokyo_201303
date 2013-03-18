class Ltsv
  def initialize
    @data = {}
  end

  def get key
    @data[key]
  end

  def set key, value
    raise ArgumentError if key.nil? || key.empty? || value.nil?

    old_value = @data[key]
    @data[key] = value
    old_value
  end

  def dump
    return_string = ""
    @data.each do |key, value|
      value = value.gsub /:/, "\\:"
      return_string << "\t" if return_string.length > 0
      return_string << "#{key}:#{value}"
    end

    return_string << "\n"
  end
end
