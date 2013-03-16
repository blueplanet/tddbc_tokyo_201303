class Ltsv
  def initialize
    @data = {}
  end

  def get key
    @data[key]
  end

  def set key, value
    if old_value = @data[key]
      @data[key] = value
      old_value
    else
      @data[key] = value
      nil
    end
  end

  def dump
    return_string = ""
    @data.each do |key, value|
      return_string << "\t" if return_string.length > 0
      return_string << "#{key}:#{value}"
    end

    return_string << "\n"
  end
end