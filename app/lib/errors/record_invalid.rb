module Errors
  class RecordInvalid < BaseError

    def initialize(error)
      super(
        title: "Unprocessable Entity",
        status: 422,
        detail: error.message
      )
    end

  end
end
