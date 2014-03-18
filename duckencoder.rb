#!/usr/bin/env ruby
#ruby encoder for duckyscript
#written in ruby v1.9.3
#Author Brian Town
#v1.0
#HID codes referenced:
#http://github.com/gentoo/hwids/blob/master/usb.ids
#credits to Jason Appelbaum for original .jar encoder
#compares values to ASCII and converts to HID hex


@@output = open('inject.bin','wb')

#processes delays
def delay_found(s)
	delay = s[0].to_i
	while delay > 0
		@@output.write('00'.hex.chr)
		if delay > 255
			@@output.write('ff'.hex.chr)
			delay -= 255
		elsif delay == 255
			@@output.write('ff'.hex.chr)
			delay = 0
		else
			delay = delay.to_s(16)
			@@output.write((delay).hex.chr)
			delay = 0
		end
	end
end

#checks for keys after finding GUI
def gui_check(s)
	s.shift
	function_check(s)
	@@output.write('08'.hex.chr)
end

#checks for function keys
def function_check(s)
	if s[0] == ('ESCAPE') || s[0] == ('ESC')
		@@output.write('29'.hex.chr)
	elsif s[0] == ('PAUSE') || s[0] == ('BREAK')
		@@output.write('48'.hex.chr)
	elsif s[0] == ('SPACE')
		@@output.write('2c'.hex.chr)
	elsif s[0] == ('TAB')
		@@output.write('2b'.hex.chr)
	elsif s[0] == ('F1')
		@@output.write('3a'.hex.chr)
	elsif s[0] == ('F2')
		@@output.write('3b'.hex.chr)
	elsif s[0] == ('F3')
		@@output.write('3c'.hex.chr)
	elsif s[0] == ('F4')
		@@output.write('3d'.hex.chr)
	elsif s[0] == ('F5')
		@@output.write('3e'.hex.chr)
	elsif s[0] == ('F6')
		@@output.write('3f'.hex.chr)
	elsif s[0] == ('F7')
		@@output.write('40'.hex.chr)
	elsif s[0] == ('F8')
		@@output.write('41'.hex.chr)
	elsif s[0] == ('F9')
		@@output.write('42'.hex.chr)
	elsif s[0] == ('F10')
		@@output.write('43'.hex.chr)
	elsif s[0] == ('F11')
		@@output.write('44'.hex.chr)
	elsif s[0] == ('F12')
		@@output.write('45'.hex.chr)
	else
		#if no correct functions found, processes first letter as a string 
		#example CTRL F14 == CTRL F
		characters = s.join(' ')
		hex = characters.unpack('U' * characters.length)
		x = hex[0]
		if (x >= 97) && (x <= 122)
			x = x - 93
			x = x.to_s(16)
			@@output.write((x).hex.chr)
		elsif (x >= 65) && (x <= 90)
			x = x - 61
			x = x.to_s(16)
			@@output.write((x).hex.chr)
		elsif (x >= 49) && (x <= 57)
			x = x - 19
			x = x.to_s(16)
			@@output.write((x).hex.chr)
		elsif x == 32
			@@output.write('2c'.hex.chr)
		else 
			@@output.write('00'.hex.chr)
		end
	end	
end

#checks for keys pressed after SHIFT
def shift_check(s)
	if s[0] == ('HOME')
		@@output.write('4a'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('TAB')
		@@output.write('2b'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('WINDOWS') || s[0] == ('GUI')
		@@output.write('e3'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('INSERT') 
		@@output.write('49'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('PAGEUP')
		@@output.write('4b'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('PAGEDOWN')
		@@output.write('4e'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('DELETE')
		@@output.write('4c'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('UPARROW')
		@@output.write('52'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('DOWNARROW')
		@@output.write('51'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('LEFTARROW')
		@@output.write('50'.hex.chr)
		@@output.write('e1'.hex.chr)
	elsif s[0] == ('RIGHTARROW')
		@@output.write('4f'.hex.chr)
		@@output.write('e1'.hex.chr)
	else
		@@output.write('e1'.hex.chr)
		@@output.write('00'.hex.chr)
	end
end

#processes strings
def string_found(s)
        characters = s.join(' ')
	hex = characters.unpack('U' * characters.length)
	hex.each do |x|
		if (x >= 97) && (x <= 122)
		x = x - 93
		x = x.to_s(16)
		@@output.write((x).hex.chr)
		@@output.write('00'.hex.chr)
		elsif (x >= 65) && (x <= 90)
		x = x - 61
		x = x.to_s(16)
		@@output.write((x).hex.chr)
		@@output.write('02'.hex.chr)
		elsif (x >= 49) && (x <= 57)
		x = x - 19
		x = x.to_s(16)
		@@output.write((x).hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 32
		@@output.write('2c'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 33
		@@output.write('1e'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 64
		@@output.write('1f'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 35
		@@output.write('20'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 36
		@@output.write('21'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 37
		@@output.write('22'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 94
		@@output.write('23'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 38
		@@output.write('24'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 42
		@@output.write('25'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 40
		@@output.write('26'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 48
		@@output.write('27'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 41
		@@output.write('27'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 45
		@@output.write('2d'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 95
		@@output.write('2d'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 61
		@@output.write('2e'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 43
		@@output.write('2e'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 91
		@@output.write('2f'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 123
		@@output.write('2f'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 93
		@@output.write('30'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 125
		@@output.write('30'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 92
		@@output.write('31'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 124
		@@output.write('31'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 59
		@@output.write('33'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 58
		@@output.write('33'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 39
		@@output.write('34'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 34
		@@output.write('34'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 96
		@@output.write('35'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 126 
		@@output.write('35'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 44
		@@output.write('36'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 60
		@@output.write('36'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 46
		@@output.write('37'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 62
		@@output.write('37'.hex.chr)
		@@output.write('02'.hex.chr)
		elsif x == 47
		@@output.write('38'.hex.chr)
		@@output.write('00'.hex.chr)
		elsif x == 63
		@@output.write('38'.hex.chr)
		@@output.write('02'.hex.chr)
		end
	end
end

#sets up array of function keys
def keys
	$f = []
	keys = (1..12)
	keys.each do |x|
		$f << "F" + x.to_s
	end
end

#main
def reader(file, index)
	keys
	current = file[index].split(' ')
	if current[0] == 'DELAY'
		current.shift
		delay_found(current)
	elsif current[0] == 'DEFAULTDELAY' || current[0] == 'DEFAULT'
	elsif current[0] == '/' || current[0] == '//'
	elsif current[0] == 'CONTROL' || current[0] == 'CTRL'
		current.shift
		function_check(current)
		@@output.write('01'.hex.chr)
	elsif current[0] == 'ALT'
		current.shift
		function_check(current)
		@@output.write('e2'.hex.chr)
	elsif current[0] == 'ENTER'
		@@output.write('28'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'SHIFT'
		current.shift
		shift_check(current)
	elsif current[0] == 'REM'
	elsif current[0] == 'MENU' || current[0] == 'APP'
		@@output.write('65'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'TAB'
		@@output.write('2b'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'SPACE'
		@@output.write('2c'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif (current[0] == 'WINDOWS' || current[0] == 'GUI') && current[1] != nil
		gui_check(current)
	elsif current[0] == 'SYSTEMPOWER'
		@@output.write('81'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'SYSTEMSLEEP'
		@@output.write('82'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'SYSTEMWAKE'
		@@output.write('83'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'ESCAPE' || current[0] == 'ESC'
		@@output.write('29'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'CAPSLOCK'
		@@output.write('39'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'PRINTSCREEN'
		@@output.write('46'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'SCROLLLOCK'
		@@output.write('47'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'BREAK' || current[0] == 'PAUSE'
		@@output.write('48'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'INSERT'
		@@output.write('49'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'HOME'
		@@output.write('4a'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'END'
		@@output.write('4d'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'PAGEUP'
		@@output.write('4b'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'DELETE'
		@@output.write('4c'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'PAGEDOWN'
		@@output.write('4e'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'RIGHTARROW' || current[0] == 'RIGHT'
		@@output.write('4f'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'LEFTARROW' || current[0] == 'LEFT'
		@@output.write('50'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'DOWNARROW' || current[0] == 'DOWN'
		@@output.write('51'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'UPARROW' || current[0] == 'UP'
		@@output.write('52'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'NUMLOCK'
		@@output.write('53'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'STOP'
		@@output.write('b5'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'PLAY'
		@@output.write('cd'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'MUTE'
		@@output.write('e2'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'VOLUMEUP'
		@@output.write('e9'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'VOLUMEDOWN'
		@@output.write('ea'.hex.chr)
		@@output.write('00'.hex.chr)
	elsif $f.include? current[0]
		function_check(current)
		@@output.write('00'.hex.chr)
	elsif current[0] == 'STRING'
		current.shift
		string_found(current)
	elsif current[0] == 'REPEAT'
		times = current[1].to_i
		for i in (0..times - 1)
			reader(file, index - 1)
		end
	else
		print '##ERROR FOUND##' "\n"
		print '##Unrecognized Command on line:: %d ##' "\n" %(index + 1)
	end

end

acceptedformat = [".txt"]

if ARGV[0] == '-h' || ARGV[0] == nil
	print "Usage: ./input.rb FILENAME.txt" "\n"
	print "ONLY FILES WITH EXTENSION .txt ACCEPTED" "\n"
elsif !File.exists?(ARGV[0])
	print "##FILE NOT FOUND##" "\n"
	print "Specify file location or use -h" "\n"
else
	if acceptedformat.include? File.extname(ARGV[0])
		file = open(ARGV[0])
		hello = file.readlines
		for i in (0..hello.length - 1)
			reader(hello,i)
		end
	else
		print "FILE TYPE NOT ACCEPTED. PLEASE CONVERT TO .TXT" "\n"
	end
end
