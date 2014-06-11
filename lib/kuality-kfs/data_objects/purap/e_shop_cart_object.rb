class EShopCartObject < DataObject

  include DateFactory
  include Utilities
  include GlobalConfig

  attr_accessor :cart_name, :description, :business_purpose,
                # == Collections ==
                :items # items is a hash of ProductLineCollections, keyed on (snake_case'd) supplier name

  # Hooks:
  def defaults
    {
      cart_name:   random_alphanums(37, 'AFT'),
      description: random_alphanums(37, 'AFT'),
      items:       {}
    }
  end

  def extended_defaults
    Hash.new
  end

  def initialize(browser, opts={})
    @browser = browser
    set_options(defaults.merge(extended_defaults).merge(opts))
  end

  def create
    pre_create
    build
    fill_out_extended_attributes
    post_create

    on page_class_for(document_object_of(self.class)) do |page|
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      @document_id = page.document_id
      page.send(@press) unless @press.nil?
    end

  rescue Watir::Exception::UnknownObjectException => uoe
    unless uoe.message.match(/:title=>"Create a new record", :tag_name=>"a"/).nil?
      raise ArgumentError, '"Create New" button was not found on this page. ' <<
          'Does the current user have the permissions necessary ' <<
          'for creating a document of this type?' <<
          "\nOriginal Exception: #{uoe}"
    end

    raise uoe
  end

  def pre_create; end

  def build; end

  def fill_out_extended_attributes(attribute_group=nil); end

  def post_create;  end

  def update_line_objects_from_page!(target=:new); end

  def update_extended_line_objects_from_page!(target=:new); end

  def absorb
    on ShopCartPage do |scp|
      update_options({

                     })
    end
  end

  def save
    on(ShopCartPage).save_shopping_cart
  end

  def submit
    on(ShopCartPage).submit_shopping_cart
  end

  def add_note(note)
    on ShopCartPage do |scp|
      scp.add_note_link.click if scp.add_note_link.exists?
      scp.add_note_textarea.fit note
      scp.save_shopping_cart
      @business_purpose = note
    end
  end

  def view(in_e_shop=true)
    visit(MainPage).e_shop unless in_e_shop
    on(EShopPage).goto_cart
  end


end #class