#!/usr/bin/env ruby
#
# Legal Stuff:
#
# This file is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/lgpl-3.0.txt>
#
#
# Thanks to the GNOME icon developers for the original version of this script


require "rexml/document"
require "fileutils"
include REXML

# INKSCAPE = 'flatpak run org.inkscape.Inkscape'
INKSCAPE = '/usr/bin/inkscape'
THEME= "Paper"
SIZES = ["16", "22", "24"]
COLORS = ["light", "dark"]

# install with `sudo npm install -g svgo`
SVGO = '/usr/local/bin/svgo'

def chopSVG(icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(SRC,icon[:file]) 
		puts " >> #{icon[:name]}"
		cmd = "#{INKSCAPE} -f #{icon[:file]} --select #{icon[:id]} --verb=FitCanvasToSelection  --verb=EditInvertInAllLayers "
		cmd += "--verb=EditDelete --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=StrokeToPath --verb=FileVacuum "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		#saving as plain SVG gets rid of the classes :/
		cmd = "#{INKSCAPE} --vacuum-defs -z #{icon[:file]} --export-plain-svg=#{icon[:file]} > /dev/null 2>&1"
		system(cmd)
		#completely vaccuum with svgo
		cmd = "#{SVGO} --pretty --disable=convertShapeToPath -i  #{icon[:file]} -o  #{icon[:file]} > /dev/null 2>&1"
		system(cmd)
		# crop
		svgcrop = Document.new(File.new(icon[:file], 'r'))
		svgcrop.root.each_element("//rect") do |rect| 
			w = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #get rid of 16 vs 15.99999 
			h = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #Inkscape bugs
			if w == 16 && h == 16
				rect.remove
			end
		end
		icon_f = File.new(icon[:file],'w+')
		icon_f.puts svgcrop
		icon_f.close
	else
		puts " -- #{icon[:name]} already exists"
	end
end #end of function

def get_output_filename(d,n)
	if (/rtl$/.match(n))
		outfile = "#{d}/#{n.chomp('-rtl')}-rtl.svg"
	else
		outfile = "#{d}/#{n}.svg"
	end
	return outfile
end

## DO IT
for COLOR in COLORS
	for SIZE in SIZES
		SRC="./#{COLOR}/source-panel-#{SIZE}.svg"
		PREFIX="../../#{THEME}/#{SIZE}x#{SIZE}"

		svg = Document.new(File.new(SRC, 'r'))

		if (ARGV[0].nil?) #render all SVGs
			puts "Rendering from icons in #{SRC}"
			# Go through every layer.
			svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context| 
				context_name = context.attributes.get_attribute("inkscape:label").value  
				puts "Going through layer '" + context_name + "'"
				context.each_element("g") do |icon|
					#puts "DEBUG #{icon.attributes.get_attribute('id')}"
					dir = "#{PREFIX}/#{context_name}"
					icon_name = icon.attributes.get_attribute("inkscape:label").value
					if icon_name.end_with?("-alt")
						puts " >> skipping icon '" + icon_name + "'"
					else
						chopSVG({ :name => icon_name,
								:id => icon.attributes.get_attribute("id"),
								:dir => dir,
								:file => get_output_filename(dir, icon_name)})
					end
				end
			end
			puts "\nrendered all SVGs"
		else #only render the icons passed
			icons = ARGV
			ARGV.each do |icon_name|
				icon = svg.root.elements["//g[@inkscape:label='#{icon_name}']"]
				dir = "#{PREFIX}/#{icon.parent.attributes['inkscape:label']}"
				chopSVG({ :name => icon_name,
						:id => icon.attributes["id"],
						:dir => dir,
						:file => get_output_filename(dir, icon_name),
						:forcerender => true})
			end
			puts "\nrendered #{ARGV.length} icons"
		end
	end
end
#EOF