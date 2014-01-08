class MainPage < BasePage

  page_url "#{$base_url}portal.jsp"

  #TODO abe to talk about links and button helper!
  #the links method should work it will take the identifier and correct into a symbol
  #example: links 'This is My Link'
  #call that method with this_is_my_link

  links 'Account', 'Account Global'



  #action(:account) { |b| b.frm.link(text: 'Account').click }
  #action(:account_global) { |b| b.frm.link(text: 'Account Global').click }


end