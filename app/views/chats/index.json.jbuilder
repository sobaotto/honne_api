# frozen_string_literal: true

json.chats do
  json.array! @chats || []
end
