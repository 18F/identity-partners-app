module FlashesHelper
  VALID_KEYS = %w[warning error info success].freeze
  INVALID_KEYS = %w[alert notice].freeze
  FLASH_KEY_MAP = {
    'alert' => 'warning',
    'notice' => 'info'
  }.freeze

  # Filter flash by valid keys and transform Devise flash keys to login.gov
  # compatible ones. Merge combined flashes if any exist.
  def user_facing_flashes
    valid_flash = flash.to_hash.slice(*VALID_KEYS)
    invalid_flash = flash.to_hash.slice(*INVALID_KEYS).transform_keys do |k|
      FLASH_KEY_MAP[k] || k
    end

    valid_flash.merge(invalid_flash) do |key, val1, val2|
      "#{val1} #{val2}"
    end
  end
end
