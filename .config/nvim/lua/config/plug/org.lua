require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/todos.org',
  mappings = {
    agenda = {
      org_agenda_switch_to = '<TAB>',
      org_agenda_goto = '<CR>',
    },
  },
})


