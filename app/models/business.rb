class Business < ApplicationRecord
  belongs_to :user

include PgSearch::model

pg_search_scope :global_search, against: :name, :description
associated_against: {
  service: %i[name description]
},
using: {
  tsearch: {prefix: true
  }
}

end
