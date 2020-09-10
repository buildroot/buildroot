#!/usr/bin/env python

from base64 import b64encode
from collections import defaultdict
from crypt import crypt
from ctypes import (
	POINTER, Structure, Union, byref, cast, get_errno, pointer,
	c_void_p, c_char, c_char_p, c_byte, c_ushort, c_int, c_uint,
	c_uint16
	)
from ctypes.util import find_library
from getpass import getuser
from os import (
	O_CREAT, O_EXCL, O_WRONLY,
	fdopen, link, open as osopen, remove, rename, urandom
	)
from os.path import join as joinpath, realpath
from socket import AF_INET, inet_ntop
from spwd import getspnam
from sys import argv
from time import time

import pygame

LOGIN_DISABLED, LOGIN_PASSWORD, LOGIN_NOPASSWORD, LOGIN_UNKNOWN = range(4)
loginLabels = 'disabled', 'with password', 'without password', 'unknown'

def checkLogin(user):
	try:
		fields = getspnam(user)
	except KeyError:
		return LOGIN_DISABLED
	except OSError:
		return LOGIN_UNKNOWN
	if fields.sp_pwd == '':
		return LOGIN_NOPASSWORD
	elif fields.sp_pwd == '*':
		return LOGIN_DISABLED
	else:
		return LOGIN_PASSWORD

def llopen(path, mode, flags, perms = 0o777):
	fd = osopen(path, flags, perms)
	return fdopen(fd, mode)

def updateShadowPassword(user, encryptedPassword):
	def updateFields(fields):
		fields.extend([''] * (9 - len(fields)))
		fields[0] = user
		fields[1] = encryptedPassword
		fields[2] = str(int(time() / (24 * 60 * 60)))

	shadowPath = realpath('/etc/shadow')
	tempPath = shadowPath + '+'
	backupPath = shadowPath + '-'

	with llopen(tempPath, 'w', O_WRONLY | O_CREAT, 0o600) as out:
		userFound = False
		try:
			with open(shadowPath, 'r') as inp:
				for line in inp:
					line = line.strip()
					fields = line.split(':')
					if fields[0] == user:
						userFound = True
						updateFields(fields)
						out.write(':'.join(fields) + '\n')
					else:
						out.write(line + '\n')
		except (IOError, OSError):
			# Treat missing or invalid shadow password file as empty.
			pass
		if not userFound:
			fields = []
			updateFields(fields)
			out.write(':'.join(fields) + '\n')

	try:
		remove(backupPath)
	except OSError:
		pass
	try:
		link(shadowPath, backupPath)
	except OSError:
		pass
	rename(tempPath, shadowPath)

def checkedUpdateShadowPassword(user, encryptedPassword):
	global errorLine
	try:
		updateShadowPassword(user, encryptedPassword)
	except OSError as ex:
		errorLine = str(ex)
		return False
	else:
		errorLine = None
		return True

def doSetRandomPassword(user):
	saltBytes = 6
	pwBytes = 6
	rnd = urandom(saltBytes + pwBytes)
	b64 = b64encode(rnd[ : saltBytes])
	salt = str(b64).rstrip('=').replace('+', '.')
	password = ''.join(
		chr(ord('a') + ord(ch) % 26) for ch in str(rnd[saltBytes : ])
		)

	if checkedUpdateShadowPassword(user, crypt(password, salt)):
		global loginStatus, displayPassword
		displayPassword = password
		loginStatus = LOGIN_PASSWORD

def doSetNoPassword(user):
	if checkedUpdateShadowPassword(user, ''):
		global loginStatus
		loginStatus = LOGIN_NOPASSWORD

def doSetInvalidPassword(user):
	if checkedUpdateShadowPassword(user, '*'):
		global loginStatus
		loginStatus = LOGIN_DISABLED

def doExit(user):
	global exitFlag
	exitFlag = True

def drawStringWithShadow(text, font, pos):
	shadowPos = (pos[0] + 2, pos[1] + 2)
	screen.blit(font.render(text, True, (0, 0, 0)), shadowPos)
	screen.blit(font.render(text, True, (255, 255, 255)), pos)

def drawString(text, font, pos):
	screen.blit(font.render(text, True, (255, 255, 255)), pos)

def paintBackground():
	w, h = screen.get_size()
	grad = 80
	for y in range(grad):
		screen.fill((grad - 1 - y, 0, grad - 1 - y), (0, y, w, y))
	screen.fill((0, 0, 0), (0, grad, w, h - grad))

	drawStringWithShadow('Configure Password', titleFont, (8, 4))

def paintStatus(user):
	statusLine = 'Current setting:  login %s' % loginLabels[loginStatus]
	if errorLine is not None:
		commentLine = errorLine
	elif loginStatus == LOGIN_NOPASSWORD:
		commentLine = 'NOTE:  Anyone on the network can log in!'
	elif loginStatus == LOGIN_PASSWORD and displayPassword is not None:
		commentLine = 'Password:  %s' % displayPassword
	else:
		commentLine = ''

	drawString('Login with user name: ' + user, normalFont, (8, 30))
	drawString(statusLine, normalFont, (8, 48))
	drawString(commentLine, normalFont, (8, 64))

menuOptions = (
	('Set random password', doSetRandomPassword),
	('Allow login without password', doSetNoPassword),
	('Disable login', doSetInvalidPassword),
	('Exit', doExit),
	)

def paintMenu():
	w, h = screen.get_size()
	y = h - 18 * len(menuOptions)
	for idx, (label, _) in enumerate(menuOptions):
		screen.fill(
			(64, 0, 64) if idx == currentOption else (16, 0, 16),
			(4, y, w - 8, 18)
			)
		drawString(label, normalFont, (8, y))
		y += 18

def paint(user):
	paintBackground()
	paintStatus(user)
	paintMenu()

def handleEvent(event, user):
	global currentOption, exitFlag

	if event.type == pygame.QUIT:
		exitFlag = True
	elif event.type == pygame.KEYDOWN:
		if event.key == pygame.K_UP:
			currentOption = (currentOption - 1) % len(menuOptions)
		elif event.key == pygame.K_DOWN:
			currentOption = (currentOption + 1) % len(menuOptions)
		elif event.key in (pygame.K_LCTRL, pygame.K_RETURN):
			menuOptions[currentOption][1](user)
		elif event.key == pygame.K_ESCAPE:
			exitFlag = True

def mainLoop(user):
	global currentOption, exitFlag
	currentOption = len(menuOptions) - 1
	exitFlag = False

	while not exitFlag:
		paint(user)
		pygame.display.flip()

		handleEvent(pygame.event.wait(), user)
		for event in pygame.event.get():
			handleEvent(event, user)

def init(user):
	global errorLine
	errorLine = None

	pygame.init()
	pygame.mouse.set_visible(False)

	global screen
	screen = pygame.display.set_mode((0, 0), pygame.DOUBLEBUF)

	pygame.display.toggle_fullscreen()

	global titleFont, normalFont
	fontDir = '/usr/share/fonts/truetype/dejavu/'
	titleFont = pygame.font.Font(fontDir + 'DejaVuSansCondensed-Bold.ttf', 20)
	normalFont = pygame.font.Font(fontDir + 'DejaVuSansCondensed.ttf', 13)

	global loginStatus, displayPassword
	loginStatus = checkLogin(user)
	displayPassword = None

def exit():
	pygame.quit()

def main():
	if len(argv) > 1:
		user = argv[1]
	else:
		user = getuser()
	init(user)
	mainLoop(user)
	exit()

if __name__ == '__main__':
	main()

# kate: indent-width 4; tab-width 4;
