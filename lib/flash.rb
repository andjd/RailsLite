class Flash
  def initialize(req)
    flash_cookie = req.cookies.select { |c| c.name = _rla_flash}
    if flash_cookie.empty?
      @this_flash = {}
    else
      @this_flash = JSON.parse(flash_cookie.first.value)
    end
      @next_flash = {}
  end

  def [](key)
    @this_flash[key]
  end

  def []=(key, val)
    @next_flash[key] = val
  end

  def current_flash= (key, val)
    @this_flash[key] = val
  end



  def store_flash(res)
    res.cookies << WEBrick::Cookie.new("_rla_flash", @next_flash.to_json)
  end

end
