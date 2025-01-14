module Slang
  module Nodes
    class Doctype < Node
      def to_s(str, buffer_name)
        str << "#{buffer_name} << \"<!DOCTYPE #{value}>\"\n"
      end

      def to_html(str)
        str << "<!DOCTYPE #{value}>"
      end
    end
  end
end
