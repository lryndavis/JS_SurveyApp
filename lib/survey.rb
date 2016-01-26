class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:upcase_name)

  private

    define_method(:upcase_name) do
      self.name=(name().titlecase())
    end
end
