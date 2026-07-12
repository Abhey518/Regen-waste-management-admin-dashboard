-- Create super_admins table
CREATE TABLE public.super_admins (
  id UUID NOT NULL DEFAULT gen_random_uuid(),
  admin_id TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  CONSTRAINT super_admins_pkey PRIMARY KEY (id),
  CONSTRAINT super_admins_admin_id_key UNIQUE (admin_id)
) TABLESPACE pg_default;

-- Create admins table
CREATE TABLE public.admins (
  id UUID NOT NULL DEFAULT gen_random_uuid(),
  admin_id TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  province_id INTEGER NOT NULL,
  district_id INTEGER NOT NULL,
  local_authority_id INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  CONSTRAINT admins_pkey PRIMARY KEY (id),
  CONSTRAINT admins_admin_id_key UNIQUE (admin_id),
  CONSTRAINT admins_province_id_fkey FOREIGN KEY (province_id) REFERENCES provinces (id),
  CONSTRAINT admins_district_id_fkey FOREIGN KEY (district_id) REFERENCES districts (id),
  CONSTRAINT admins_local_authority_id_fkey FOREIGN KEY (local_authority_id) REFERENCES local_authorities (id)
) TABLESPACE pg_default;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_admins_admin_id ON public.admins USING btree (admin_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_admins_province ON public.admins USING btree (province_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_admins_district ON public.admins USING btree (district_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_admins_local_authority ON public.admins USING btree (local_authority_id) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_super_admins_admin_id ON public.super_admins USING btree (admin_id) TABLESPACE pg_default;

-- Add triggers for timestamp updates (assuming you have the update_timestamp function)
CREATE TRIGGER update_admin_timestamp 
  BEFORE UPDATE ON admins 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_super_admin_timestamp 
  BEFORE UPDATE ON super_admins 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- Insert a default super admin (you can change the credentials)
INSERT INTO public.super_admins (admin_id, password) 
VALUES ('RA0000S', 'SuperAdmin123') 
ON CONFLICT (admin_id) DO NOTHING;
