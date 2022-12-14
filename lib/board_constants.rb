# frozen_string_literal: true

module BoardConstants
  COL_QUANTITY = 7
  ROW_QUANTITY = 6
  COL_LOWER_INDEX = 0
  COL_UPPER_INDEX = COL_QUANTITY - 1
  ROW_UPPER_INDEX = ROW_QUANTITY - 1
  LOWER_INPUT = (COL_LOWER_INDEX + 1).to_s
  UPPER_INPUT = (COL_UPPER_INDEX + 1).to_s
end
