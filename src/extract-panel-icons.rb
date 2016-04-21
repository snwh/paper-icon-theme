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
#INKSCAPE = '/usr/bin/inkscape' # like this works for me, while using `which` inkscape hangs

# Render 24x24 pixel panel icons
SRC24 = "panel/source-panel-24.svg"
PREFIX24 = "../Paper/24x24"


def chopSVG(icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(SRC24,icon[:file]) 
		puts " >> #{icon[:name]}"
		cmd = "#{INKSCAPE} -f #{icon[:file]} --select #{icon[:id]} --verb=FitCanvasToSelection  --verb=EditInvertInAllLayers "
		cmd += "--verb=EditDelete --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=StrokeToPath --verb=FileVacuum "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		#saving as plain SVG gets rid of the classes :/
		#cmd = "#{INKSCAPE} -f #{icon[:file]} -z --vacuum-defs -l #{icon[:file]} > /dev/null 2>&1"
		#system(cmd)
		svgcrop = Document.new(File.new(icon[:file], 'r'))
		svgcrop.root.each_element("//rect") do |rect| 
			w = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #get rid of 24 vs 23.99999 
			h = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #Inkscape bugs
			if w == 24 && h == 24
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

#main
# Open SVG file.
svg = Document.new(File.new(SRC24, 'r'))

if (ARGV[0].nil?) #render all SVGs
  puts "Rendering from icons in #{SRC24}"
	# Go through every layer.
	svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context| 
		context_name = context.attributes.get_attribute("inkscape:label").value  
		puts "Going through layer '" + context_name + "'"
		context.each_element("g") do |icon|
			#puts "DEBUG #{icon.attributes.get_attribute('id')}"
			dir = "#{PREFIX24}/#{context_name}"
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
  	dir = "#{PREFIX24}/#{icon.parent.attributes['inkscape:label']}"
		chopSVG({	:name => icon_name,
		 					:id => icon.attributes["id"],
		 					:dir => dir,
		 					:file => get_output_filename(dir, icon_name),
		 					:forcerender => true})
	end
  puts "\nrendered #{ARGV.length} icons"
end


# Render 22x22 pixel panel icons
SRC22 = "panel/source-panel-22.svg"
PREFIX22 = "../Paper/22x22"


def chopSVG(icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(SRC22,icon[:file]) 
		puts " >> #{icon[:name]}"
		cmd = "#{INKSCAPE} -f #{icon[:file]} --select #{icon[:id]} --verb=FitCanvasToSelection  --verb=EditInvertInAllLayers "
		cmd += "--verb=EditDelete --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=StrokeToPath --verb=FileVacuum "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		#saving as plain SVG gets rid of the classes :/
		#cmd = "#{INKSCAPE} -f #{icon[:file]} -z --vacuum-defs -l #{icon[:file]} > /dev/null 2>&1"
		#system(cmd)
		svgcrop = Document.new(File.new(icon[:file], 'r'))
		svgcrop.root.each_element("//rect") do |rect| 
			w = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #get rid of 24 vs 23.99999 
			h = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #Inkscape bugs
			if w == 24 && h == 24
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

#main
# Open SVG file.
svg = Document.new(File.new(SRC22, 'r'))

if (ARGV[0].nil?) #render all SVGs
  puts "Rendering from icons in #{SRC22}"
	# Go through every layer.
	svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context| 
		context_name = context.attributes.get_attribute("inkscape:label").value  
		puts "Going through layer '" + context_name + "'"
		context.each_element("g") do |icon|
			#puts "DEBUG #{icon.attributes.get_attribute('id')}"
			dir = "#{PREFIX22}/#{context_name}"
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
  	dir = "#{PREFIX22}/#{icon.parent.attributes['inkscape:label']}"
		chopSVG({	:name => icon_name,
		 					:id => icon.attributes["id"],
		 					:dir => dir,
		 					:file => get_output_filename(dir, icon_name),
		 					:forcerender => true})
	end
  puts "\nrendered #{ARGV.length} icons"
end

# Render 16x16 pixel panel icons
SRC16 = "panel/source-panel-16.svg"
PREFIX16 = "../Paper/16x16"


def chopSVG(icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(SRC16,icon[:file]) 
		puts " >> #{icon[:name]}"
		cmd = "#{INKSCAPE} -f #{icon[:file]} --select #{icon[:id]} --verb=FitCanvasToSelection  --verb=EditInvertInAllLayers "
		cmd += "--verb=EditDelete --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=StrokeToPath --verb=FileVacuum "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)
		#saving as plain SVG gets rid of the classes :/
		#cmd = "#{INKSCAPE} -f #{icon[:file]} -z --vacuum-defs -l #{icon[:file]} > /dev/null 2>&1"
		#system(cmd)
		svgcrop = Document.new(File.new(icon[:file], 'r'))
		svgcrop.root.each_element("//rect") do |rect| 
			w = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #get rid of 24 vs 23.99999 
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

#main
# Open SVG file.
svg = Document.new(File.new(SRC16, 'r'))

if (ARGV[0].nil?) #render all SVGs
  puts "Rendering from icons in #{SRC16}"
	# Go through every layer.
	svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context| 
		context_name = context.attributes.get_attribute("inkscape:label").value  
		puts "Going through layer '" + context_name + "'"
		context.each_element("g") do |icon|
			#puts "DEBUG #{icon.attributes.get_attribute('id')}"
			dir = "#{PREFIX16}/#{context_name}"
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
  	dir = "#{PREFIX16}/#{icon.parent.attributes['inkscape:label']}"
		chopSVG({	:name => icon_name,
		 					:id => icon.attributes["id"],
		 					:dir => dir,
		 					:file => get_output_filename(dir, icon_name),
		 					:forcerender => true})
	end
  puts "\nrendered #{ARGV.length} icons"
end

#EOF