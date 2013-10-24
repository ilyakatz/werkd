##
# Class override to make yaml_db work in rails 4.0.
#
class ActiveRecord::Result

  def []=(idx,value)
    hash_rows
    @hash_rows[idx] = value
    value
  end

end
