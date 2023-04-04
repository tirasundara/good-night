module Errors
  class RecordNotFound < BaseError

    def initialize(*args)
      super(
        title: "Record not Found",
        status: 404,
        detail: "We could not find the object you were looking for."
      )
    end

  end
end
