namespace :dummy_data do
  desc "create some dummy data"

  task :create_television_data => :environment do
    tv = []
    tv_p = ["BROADCAST", "SERAMBI", "INDONESIA PAGI", "SEMANGAT PAGI", "INDONESIA TERKINI", "INDONESIA MEMBANGUN", "INDONESIA MALAM", "MERAJUT NKRI", "DUNIA TERBALIK", "SEPUTAR INDONESIA PAGI", "INFO BISNIS", "GO SPOT", "TOPIK PAGI", "LENSA OLAH RAGA PAGI", "MASHA AND THE BEAR"]
    level = ["Religious", "Information", "News", "Sport", "Filler"]
    cat = ["TV PROGRAMME PROMOTION", "MEDIA SELF PROMOTION", "PUBLIC SERVICE ADVERTISEMENT (PSA)", "GOVERNMENT, POLITIC ORGANIZATION"]
    sec = ["NON-COMMERCIAL ADVERTISEMENT", "SERVICES - CORPORATE & PUBLIC SERV ADV"]
    adv = ["TELEVISI REPUBLIK INDONESIA", "PUBLIC SERVICE AD (PSA)", "KEMENTERIAN KOM DAN INFO RI"]
    prod = ["PP RELIGIOUS S001", "PP NEWS I001", "SELF PROMO", "PUBLIC SERVICE AD (PSA)", "KEMENTERIAN KOMUNIKASI DAN INFORMASI RI"]
    cop = ["TV 1","TV 2","TV 3","TV 4","TV 5","TV 6","TV 7"]
    c = Channel.all.ids
    s_time = rand(10..50)
    e_time = s_time + 10
    cos = rand(100..1000)*1000
    target = ["Total Individuals", "MF 15+ UM"]
    1.times do |i|
      @television_program = TelevisionProgram.new
      post_buy = @television_program.build_post_buy
      post_buy.build_viewer

      tv << TelevisionProgram.new(
        program: tv_p.sample, 
        level_1: level.sample, 
        level_2: level.sample, 
        cost: cos, 
        channel_id: c.sample, 
        start_time: s_time, 
        end_time: e_time, 
        duration: e_time - s_time , 
        st_video: s_time, 
        et_video: e_time, 
        post_buy_attributes: {
          sector: sec.sample, 
          category: cat.sample , 
          advertiser: adv.sample, 
          product: prod.sample , 
          copy: cop.sample , 
          break_no: rand(1..15), 
          pos_in_break: rand(1..15), 
          break: rand(1..15) , 
          spot_type: "LOOSE SPOT", 
          size: "100%", 
          t_second_cost: cos, 
          viewer_attributes: { 
            market: "ALL-Markets", 
            activity: "Non Bedtime Viewing", 
            target: target.sample, 
            day_part_or_variable: "#{s_time} - #{e_time}", 
            tVR: rand(1..3), 
            share: rand(1..3), 
            '000s': rand(10..500), 
            index: "n.a" 
          } 
        }
      )
      TelevisionProgram.import tv, :recursive => true
    end
  end
end