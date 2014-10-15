$ ->
        Morris.Line
                element: 'submissions-chart'
                data: $('#submissions-chart').data('submissions')
                xkey: 'created_at'
                ykeys: ['all_submissions', 'all_confirmations']
                labels: ['Submissions', 'Confirmed submissions']
                lineColors: ['#D9230F', '#469408']
                resize: true
