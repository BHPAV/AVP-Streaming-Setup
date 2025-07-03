import os
import sys
sys.path.insert(0, os.path.abspath('..'))

project = 'AVP Streaming Setup'
author = 'AVP Streaming Setup'
release = '0.1.0'

extensions = [
    'sphinx.ext.autodoc',
]

autodoc_default_options = {
    'members': True,
    'undoc-members': True,
    'special-members': '__init__',
    'inherited-members': True,
    'show-inheritance': True,
}

html_theme = 'sphinx_rtd_theme'

templates_path = ['_templates']
exclude_patterns = ['_build'] 