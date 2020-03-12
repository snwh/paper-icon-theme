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

INKSCAPE = 'flatpak run org.inkscape.Inkscape'
#INKSCAPE = '/usr/bin/inkscape'
SRC = "./source-symbolic.svg"
PREFIX = "../../Paper/scalable"

# SVGO is a Node.js SVG optimization tool install with 'sudo npm install -g svgo'
# script will skip if SVGO is not present
#SVGO = '/usr/local/bin/svgo'
SVGO = '/usr/bin/svgo'

def chopSVG(icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(SRC,icon[:file]) 
		puts " >> #{icon[:name]}"
		# extract the icon
		cmd = "#{INKSCAPE} -f #{icon[:file]} "
		cmd += "--select #{icon[:id]} --verb=FitCanvasToSelection --verb=EditInvertInAllLayers --verb=EditDelete " # delete everything but the icon
		cmd += "--verb=FileVacuum --verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		# remove bounding rectangle
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
		# convert any strokes and objects to paths
		cmd = "#{INKSCAPE} -f #{icon[:file]} --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=ObjectToPath --verb=StrokeToPath "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		# save as plain SVG
		cmd = "#{INKSCAPE} -f #{icon[:file]} -z --vacuum-defs --export-plain-svg=#{icon[:file]} > /dev/null 2>&1"
		system(cmd)
		# remove as many extraneous elements as possible with SVGO
		cmd = "#{SVGO} --pretty --disable=convertShapeToPath --disable=convertPathData --enable=removeStyleElement -i #{icon[:file]} -o  #{icon[:file]} > /dev/null 2>&1"
		system(cmd)
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
			# prevent rendering of icons ending in :
			if icon_name.end_with?("-alt", "-old", "-template", "-source", "-ltr", "-working")
				puts " ++ skipping icon '" + icon_name + "'"
			elsif icon_name =~ /\d$/
				puts " ++ skipping icon '" + icon_name + "'"
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
		if icon_name == "process-working"
			dir = "#{PREFIX32}/#{icon.parent.attributes['inkscape:label']}"
		else
			dir = "#{PREFIX}/#{icon.parent.attributes['inkscape:label']}"
		end
		chopSVG({	:name => icon_name,
					:id => icon.attributes["id"],
					:dir => dir,
					:file => get_output_filename(dir, icon_name),
					:forcerender => true})
	end
	puts "\nrendered #{ARGV.length} icons"
end
