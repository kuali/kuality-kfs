module IndirectCostRecoveryLinesMixin

  # Include this mixin at the bottom of your class definition for best results.
  # Otherwise, the methods it extends may not be defined when the mixin is evaluated.
  # @param [Class] base_class Class that the mixin will be added to
  # @return [Class] Merged Class
  def self.included(base_class)
    base_class.class_eval do

      attr_accessor :initial_icr_accounts
      attr_reader :icr_accounts


      class << self
        def icra_mixin_attributes
          [:initial_icr_accounts, :icr_accounts]
        end
      end

      # @param [Array] icras An array of Hashes representing an update to the @icr_accounts collection
      def icr_accounts=(icras)
        # If we're initializing, copying or resetting, just take the collection as-is
        if icras.instance_of? IndirectCostRecoveryLineObjectCollection
          @icr_accounts = icras
          return
        end

        # Otherwise, we're adding or editing elements and we want a Hash.
        raise ArgumentError, 'All Indirect Cost Recovery line updates must be supplied as Hashes!' unless icras.all? {|icra| icra.is_a? Hash }

        # Load them in the prescribed order. If no number is provided, throw them at the end in the order given
        i = -1
        icras.sort_by! { |icra| icra[:line_number].nil? ? (i+=1; icras.length*2+i) : icra[:line_number] }
        icras.each do |icra|
          case
            when icra[:line_number].nil?, @icr_accounts.length == icra[:line_number]
              @icr_accounts.add icra # New line
            when @icr_accounts.length + 1 < icra[:line_number]
              raise ArgumentError, "Can't add an Indirect Cost Recovery with line number #{icra[:line_number]} because there are only #{@icr_accounts.length} lines so far."
            else
              @icr_accounts[icra[:line_number]].edit icra # Update a line
          end
        end
      end

      def default_icr_accounts(opts={})
        # This just makes it so we don't have to be so repetitive. It can certainly be
        # overridden in a subclass if you don't want to chuck things in via opts.
        {
          icr_accounts:         collection('IndirectCostRecoveryLineObject'),
          initial_icr_accounts: []
        }.merge(opts)
      end


      # back up methods to be extended. Use these instead of #super in the extended methods
      alias_method :super_post_create, :post_create
      alias_method :super_edit, :edit
      alias_method :super_update_line_objects_from_page!, :update_line_objects_from_page!
      def post_create
        super_post_create
        @initial_icr_accounts.each{ |il| @icr_accounts.add il }
        @initial_icr_accounts = nil
      end

      def edit(opts={})
        self.icr_accounts = opts[:icr_accounts] unless opts[:icr_accounts].nil?
        super_edit(opts)
      end

      def update_line_objects_from_page!(target=:new)
        super_update_line_objects_from_page!
        @icr_accounts.update_from_page! target
      end

    end
  end
end