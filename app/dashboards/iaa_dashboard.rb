require "administrate/base_dashboard"

class IAADashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    account: Field::BelongsTo,
    id: Field::Number,
    number: Field::String,
    start_date: Field::Date,
    end_date: Field::Date,
    signed_date: Field::Date,
    estimated_amount: Field::Number,
    billed_amount: Field::Number,
    active: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  number
  active
  end_date
  account
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  account
  id
  number
  start_date
  end_date
  signed_date
  estimated_amount
  billed_amount
  active
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  account
  number
  start_date
  end_date
  signed_date
  estimated_amount
  billed_amount
  active
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how iaas are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(iaa)
    "#{iaa.number}"
  end
end
