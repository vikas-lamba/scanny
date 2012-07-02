module Scanny
  module Checks
    class RedirectWithParamsCheck < Check
      def pattern
        pattern_redirect
      end

      def check(node)
        issue :medium, warning_message, :cwe => 113
      end

      private

      def warning_message
        "Use of external parameters in redirect_to method" +
        "can lead to unauthorized redirects"
      end

      def pattern_redirect
        <<-EOT
          SendWithArguments<
            arguments = ActualArguments<
              array = [
                SendWithArguments<
                  name = :[],
                  receiver = Send<name = :params>
                >
              ]
            >,
            name = :redirect_to
          >
        EOT
      end
    end
  end
end