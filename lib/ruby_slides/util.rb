module RubySlides
  module Util

    def pixel_to_pt(px)
      px * 12700
    end

    def render_view(template_name, path, variables = {})
      view_contents = read_template(template_name)
      renderer = ERB.new(view_contents)
      b = merge_variables(binding, variables)
      data = renderer.result(b)

      File.open(path, 'w') { |f| f << data }
    end

    def read_template(filename)
      File.read("#{RubySlides::VIEW_PATH}/#{filename}")
    end

    def require_arguments(required_arguments, arguments)
      raise ArgumentError unless required_arguments.all? {|required_key| arguments.keys.include? required_key}
    end

    def copy_media(extract_path, image_path)
      image_name = File.basename(image_path)
      dest_path = "#{extract_path}/ppt/media/#{image_name}"
      FileUtils.copy_file(image_path, dest_path) unless File.exist?(dest_path)
    end

    def merge_variables(b, variables)
      return b if variables.empty?
      variables.each do |k,v|
        b.local_variable_set(k, v)
      end
      b
    end
  end
end
