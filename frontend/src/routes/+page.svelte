<script>
    import database from '../../../etl/db.json';

    const thisWeeksHits = database[0]

    console.log(database)
</script>
  
<h1 class='text-green-600'>Billboard hits for the week of {thisWeeksHits.date}</h1>
{#each thisWeeksHits.hits as hit}
        <div class='flex border h-8'>
            <p>{hit.last_week_position}</p>
            <p>{hit.hit_number}</p>
            <p>{hit.song_title}</p>
            <p>{hit.artist}</p>
            <p>{hit.peak_position}</p>
            <p>{hit.wks_on_chart}</p>
        </div>
{/each}