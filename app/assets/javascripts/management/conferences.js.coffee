conflictsScale=chroma.scale(['#469408', '#D9230F']).mode('lab');

$ ->
  $('.cfp-toggle').click ->
    $(this).addClass("disabled")
  if $('#submissions-chart').length > 0
    Morris.Line
      element: 'submissions-chart'
      data: $('#submissions-chart').data('submissions')
      xkey: 'created_at'
      ykeys: ['all_submissions', 'all_confirmations']
      labels: ['Submissions', 'Confirmed submissions']
      lineColors: ['#D9230F', '#469408']
      resize: true
  $('[data-conflicts]').each (e) ->
    most_conflicts = parseInt($(this).data('most-conflicts'))
    conflicts = parseInt($(this).data('conflicts'))
    least_conflicts = parseInt($(this).data('least-conflicts'))
    console.log 1.0 * (conflicts - least_conflicts) / (most_conflicts - least_conflicts)
    $(this).css('background-color', conflictsScale(1.0 * (conflicts - least_conflicts) / (most_conflicts - least_conflicts)))
