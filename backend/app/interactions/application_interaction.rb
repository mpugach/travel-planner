class ApplicationInteraction < ActiveInteraction::Base
  def run
    raise Api::NotAuthorizedError unless authorized?

    super
  end

  private

  def authorized?
    false
  end
end
