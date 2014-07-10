class EShopAdvancedSearchPage < EShopPage

  element(:key_words) { |b| b.frm.text_field(id: 'Keywords', title: 'Search terms') }

end