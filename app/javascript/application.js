// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

import { Application } from '@hotwired/stimulus'
import Sortable from 'stimulus-sortable'

const application = Application.start()
application.register('sortable', Sortable)
