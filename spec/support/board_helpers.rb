module BoardHelpers
  def create_display(display = [])
    6.times { display << create_display_row }
    return display
  end

  private

  def create_display_row(row = [])
    7.times { row << "\u25cb" }
    return row
  end
end
