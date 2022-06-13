// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import MobileNavbarController from "./mobile_navbar_controller.js"
application.register("mobile-navbar", MobileNavbarController)

import ProjectSubscriptionController from "./project_subscription_controller.js"
application.register("project-subscription", ProjectSubscriptionController)

import Select2Controller from "./select2_controller.js"
application.register("select2", Select2Controller)

import SortableController from "./sortable_controller.js"
application.register("sortable", SortableController)

import SubTasksController from "./sub_tasks_controller.js"
application.register("sub-tasks", SubTasksController)

window.Stimulus = Application.start()
const context = require.context("./controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

import TaskProgressController from "./task_progress_controller.js"
application.register("task-progress", TaskProgressController)

