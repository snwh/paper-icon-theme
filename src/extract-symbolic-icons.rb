#!/usr/bin/env ruby
#
# Legal Stuff:
#
# This file is part of the Paper Icon Theme and is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is part of the Paper Icon Theme and is distributed in the hope that it will be useful, but WITHOUT
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

INKSCAPE = '/usr/bin/inkscape'
SRC = "symbolic/source-symbolic.svg"
PREFIX = "../Paper/scalable"


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
		#cmd = "#{INKSCAPE} -f -z #{icon[:file]} -z --vacuum-defs -l #{icon[:file]} > /dev/null 2>&1"
		#system(cmd)
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
	  outfile = "#{d}/#{n.chomp('-rtl')}-symbolic-rtl.svg"
	else
	  outfile = "#{d}/#{n}-symbolic.svg"	  
  end
  return outfile
end

#main
# Open SVG file.
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
			chopSVG({	:name => icon_name,
			 					:id => icon.attributes.get_attribute("id"),
			 					:dir => dir,
			 					:file => get_output_filename(dir, icon_name)})
		end
	end
  puts "\nrendered all SVGs"
else #only render the icons passed
  icons = ARGV
  ARGV.each do |icon_name|
  	icon = svg.root.elements["//g[@inkscape:label='#{icon_name}']"]
  	dir = "#{PREFIX}/#{icon.parent.attributes['inkscape:label']}"
		chopSVG({	:name => icon_name,
		 					:id => icon.attributes["id"],
		 					:dir => dir,
		 					:file => get_output_filename(dir, icon_name),
		 					:forcerender => true})
	end
  puts "\nrendered #{ARGV.length} icons"
end

#EOF