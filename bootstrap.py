#!/usr/bin/env python
# coding=utf-8
import distutils.spawn
import os
import subprocess

HOME = os.getenv('HOME')
GOPATH = os.getenv('GOPATH')


def get_symfiles():
    root = os.path.abspath(os.path.dirname(__file__))
    for directory, _, files in os.walk(root):
        for filename in files:
            if '.' not in filename:
                continue
            start, end = filename.rsplit('.', 1)
            if end != 'symlink':
                continue
            filepath = os.path.join(directory, filename)
            yield os.path.join(directory, filename), os.path.join(HOME, '.{0}'.format(start))


def get_dest(filepath):
    exp = filepath.rsplit('.', 1)[-1]
    if exp == 'symlink':
        return os.path.join(HOME, '.' + os.path.basename(filepath[:-8]))


def go_get(url):
    return subprocess.call(['go', 'get', '-v', url])


def main():
    for source, dest in get_symfiles():
        if os.path.islink(dest) and os.readlink(dest) == source:
            continue
        elif os.path.islink(dest):
            print('{dest} is link but not to {source}... skipping...'.format(dest=dest, source=source))
        elif os.path.exists(dest):
            print('{dest} exists and is not linked to {source}... skipping...'.format(dest=dest, source=source))
        else:
            print('link {source} -> {dest}'.format(dest=dest, source=source))
            os.symlink(source, dest)

    if GOPATH and distutils.spawn.find_executable('go'):
        go_get('github.com/tanelpuhu/jobs-info-to-ps1')
        go_get('github.com/tanelpuhu/svn-info-xml-to-ps1')

    print('done, you only need to run this now: source ~/.bash_profile')


if __name__ == '__main__':
    main()
