class BaseQuery
  def call(query = {})
    raise NotImplementedError, "implement ##{__method__} in sub-class!"
  end
end
