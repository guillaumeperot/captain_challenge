class ClashEvent < ActiveRecord::Base
    belongs_to :clash

    enum attack_type: ["normal", "critical"]
    enum defend_type: ["receive", "dodge"]
end