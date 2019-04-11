""" 1. VIGENERE CIPHER """

def encrypt(plain, keyword):

    alp1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    alp2 = "abcdefghijklmnopqrstuvwxyz"

    while len(keyword) < len(plain):
        keyword += keyword

    cipher = ''
    for c in range(len(plain)):
        wc = ord(plain[c])

        if keyword[c] in alp1:
            shift = ord(keyword[c]) - 65
        elif keyword[c] in alp2:
            shift = ord(keyword[c]) - 97

        if (65 <= wc <= 90) and (65 + shift <= shift + wc <= 90):
            cipher += chr(wc + shift)
        elif (97 <= wc <= 122) and (97 + shift <= shift + wc <= 122):
            cipher += chr(wc + shift)
        elif (wc <= 64) or (91 <= wc <= 96) or (123 <= wc):
            cipher += chr(wc)
        else:
            cipher += chr(wc + shift - 26)

    return cipher


def decrypt(cipher, keyword):

    alp1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    alp2 = "abcdefghijklmnopqrstuvwxyz"

    while len(keyword) < len(cipher):
        keyword += keyword

    plain = ''
    for c in range(len(cipher)):
        wc = ord(cipher[c])

        if keyword[c] in alp1:
            shift = ord(keyword[c]) - 65
        elif keyword[c] in alp2:
            shift = ord(keyword[c]) - 97

        if (65 <= wc <= 90) and (65 <= wc - shift <= 90 - shift):
            plain += chr(wc - shift)
        elif (97 <= wc <= 122) and (97 <= wc - shift <= 122 - shift):
            plain += chr(wc - shift)
        elif (wc <= 64) or (91 <= wc <= 96) or (123 <= wc):
            plain += chr(wc)
        else:
            plain += chr(wc - shift + 26)

    return plain


""" 2. EXAMPLES """

while input('Vigenere? [y/n]: ') == 'y':
	if input('Encrypt [e] or decrypt [d]? ') == 'e':
		print(encrypt(
			input('Phrase 1: '), input('Keyword: ')
		))
	else:
		print(decrypt(
			input('Phrase 1: '), input('Keyword: ')
		))

"""
'VDOKRRVVZKOTUIIMNUUVRGFQKTOGNXVHOPGRPEVWVZYYOWKMOCZMBR'
'VIGENERE'
'AVIGENERECIPHERISMORECOMPLICATEDTHANCAESARSUBSTITUTION'

'ATTACKATDAWN'
'LEMON'
'LXFOPVEFRNHR'
"""
