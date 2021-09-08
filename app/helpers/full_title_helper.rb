module FullTitleHelper
    # Returns the head/title Tag on a per-page basis.
    def full_title(page_title = '')
      base_title = "dokodemon"
      if page_title.empty?
        base_title
      else
        page_title + " | " + base_title
      end
    end
end