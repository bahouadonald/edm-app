import re,glob,json,os
U='/mnt/user-data/uploads/'
weeks={1:'Savoir méditer la Parole de Dieu',2:'Savoir invoquer Dieu',3:'Savoir prier Dieu',4:'Savoir adorer Dieu',5:'Savoir marcher avec Dieu',6:'Savoir agir et prospérer avec Dieu',7:'Savoir offrir à Dieu'}
files={}
for f in glob.glob(U+'Semaine*_Module_*.txt'):
  m=re.search(r'Semaine(\d)_Module_(\d)',f);files[(int(m[1]),int(m[2]))]=f
for f in glob.glob(U+'Module_*.txt'):
  m=re.search(r'Module_(\d)_',f);files.setdefault((2,int(m[1])),f)
def sec(t,a,b):
  i=t.find(a);j=t.find(b,i+1) if b else len(t)
  s=t[i:j];s=s.split('\n',1)[1] if '\n' in s else s
  s=re.sub(r'^-{5,}\s*','',s.strip()).strip();return s
mods=[];n=0
for (w,k) in sorted(files):
  t=open(files[(w,k)],encoding='utf-8').read().replace('\r','')
  title=t.split('\n',1)[0].split(':',1)[1].strip().title() if ':' in t.split('\n',1)[0] else t.split('\n',1)[0]
  raw=t.split('\n',1)[0].split(':',1)[1].strip()
  obj=sec(t,'🎯','📖');cont=sec(t,'📖','📝');res=sec(t,'📝','✏️');ex=sec(t,'✏️','🔧');pra=sec(t,'🔧','📊');bil=sec(t,'📊',None)
  bil=bil.split('✅ PASSAGE')[0].strip()
  q,c=ex.split('CORRECTIONS',1) if 'CORRECTIONS' in ex else (ex,'')
  qs=[]
  for m in re.finditer(r'(?m)^(\d+)\.\s+(.+?)\n\s+A\.\s+(.+?)\n\s+B\.\s+(.+?)\n\s+C\.\s+(.+?)\n(?:\s+D\.\s+(.+?)\n)?',q+'\n'):
    qs.append({'ordre':int(m[1]),'question':m[2].strip(),'a':m[3].strip(),'b':m[4].strip(),'c':m[5].strip(),'d':(m[6] or '').strip() or None})
  for m in re.finditer(r'(?m)^(\d+)\.\s+([A-D])\.\s*(.*)$',c):
    for x in qs:
      if x['ordre']==int(m[1]): x['rep']=m[2].lower(); x['expl']=m[3].strip()
  n+=1
  mods.append(dict(numero=n,semaine=w,mod=k,raw=raw,objectifs=obj,contenu=cont,resume=res,pratique=pra,bilan=bil,questions=qs,last=False))
for i,m in enumerate(mods):
  m['last']= i==len(mods)-1 or mods[i+1]['semaine']!=m['semaine']
json.dump(mods,open('f1.json','w'),ensure_ascii=False,indent=1)
for m in mods: print(m['numero'],m['semaine'],m['mod'],m['raw'][:45],'| q',len(m['questions']),'rep',sum('rep' in x for x in m['questions']),'D',sum(bool(x['d']) for x in m['questions']),'| obj',len(m['objectifs']),'cont',len(m['contenu'].split()),'res',len(m['resume']),'pra',len(m['pratique']))
