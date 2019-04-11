""" 1. CAESAR CIPHER """

def encrypt(plain, i):
    cipher = ''
    for c in plain:

        if (65 + i <= ord(c) + i <= 90) or (97 + i <= ord(c) + i <= 122):
            # letters
            cipher += chr(ord(c) + i)

        elif (ord(c) <= 64) or (91 <= ord(c) <= 96) or (123 <= ord(c)):
            # symbols
            cipher += c

        else:
            cipher += chr(ord(c) + i - 26)

    return cipher


def decrypt(cipher, i):
    plain = ''
    for c in cipher:

        if (65 <= ord(c) - i <= 90 - i) or (97 <= ord(c) - i <= 122 - i):
            # letters
            plain += chr(ord(c) - i)

        elif (ord(c) <= 64) or (91 <= ord(c) <= 96) or (123 <= ord(c)):
            # symbols
            plain += c

        else:
            plain += chr(ord(c) - i + 26)

    return plain


""" 2. EXAMPLES """

w1 = 'Nothing but gibberish'
print('Phrase 1:', w1)
m1 = 13
print('Shift:   ', m1)
w2 = 'SBWKRQ'
print('Phrase 1:', w2)
m2 = 3
print('Shift:   ', m2)
w3 = 'Abguvat ohg tvoorevfu'
print('Phrase 1:', w3)
m3 = 13
print('Shift:   ', m3)

"""
w1 = input('Phrase 1: ')
m1 = int(input('Shift: '))
w2 = input('Phrase 2: ')
m2 = int(input('Shift: '))
w3 = input('Phrase 3: ')
m3 = int(input('Shift: '))
"""

print('\n', w1, 'encrypted on', m1, 'is:', encrypt(w1, m1))
print('\n', w2, 'decrypted on', m2, 'is:', decrypt(w2, m2))
print('\n', w3, 'decrypted on', m3, 'is:', decrypt(w3, m3))
