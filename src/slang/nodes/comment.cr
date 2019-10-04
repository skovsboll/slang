module Slang
  module Nodes
    class Comment < Node
      delegate :conditional, :visible, to: @token

      def to_s(str, buffer_name)
        if visible
          str << "#{buffer_name} << \"\n\"\n" unless str.empty?
          str << "#{buffer_name} << \"#{indentation}\"\n" if indent?
          str << "#{buffer_name} << \"<!--\"\n"
          str << "#{buffer_name} << \"[#{conditional}]>\"\n" if conditional?
          str << "#{buffer_name} << \"#{value}\"\n" if value
          if children?
            nodes.each do |node|
              node.to_s(str, buffer_name)
            end
            str << "#{buffer_name} << \"\n#{indentation}\"\n"
          end
          str << "#{buffer_name} << \"<![endif]\"\n" if conditional?
          str << "#{buffer_name} << \"-->\"\n"
        end
      end

      def to_html(str)
        if visible
          str << "\n" unless str.empty?
          str << "#{indentation}" if indent?
          str << "<!--"
          str << "[#{conditional}]>" if conditional?
          str << "#{value}" if value
          if children?
            nodes.each do |node|
              node.to_html(str)
            end
            str << "\n#{indentation}"
          end
          str << "<![endif]" if conditional?
          str << "-->"
        end
      end

      def conditional?
        !conditional.empty?
      end
    end
  end
end
