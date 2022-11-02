<script>
    import database from '../../../etl/db.json';

    const thisWeeksHits = database[0]

    // console.log(database)
</script>
 
<div class='flex my-8'>
    <h1 class='text-red-600'>Billboard hits for the week of {thisWeeksHits.date}</h1>
    <div class='divide-y-2 divide-black border-y-2 border-black'>
        {#each thisWeeksHits.hits as hit}
            <div class='grid grid-cols-12 items-center'>
                <p class='text-center'>{hit.last_week_position}</p>
                <p class='text-center text-white bg-black'>{hit.hit_number}</p>
                <div class='col-span-8 flex justify-between'>
                    <strong>{hit.song_title.toUpperCase()}</strong>
                    <p>{hit.artist}</p>
                </div>
                <p class='text-center'>{hit.peak_position}</p>
                <p class='text-center'>{hit.wks_on_chart}</p>
            </div>
        {/each}
    </div>
</div>
